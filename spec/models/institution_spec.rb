require 'spec_helper'

describe Institution do
  let (:i) { FactoryGirl.create(:institution) }

  after do 
    i.delete
  end

  it { should validate_presence_of(:name) }
  
  it 'should serialize descMetadata as RDF triples' do 
    i.descMetadata.serialize.should == "<info:fedora/#{i.pid}> <http://purl.org/dc/terms/title> \"#{i.name}\" .\n"
  end

  it 'should retun a proper solr_doc' do
    i.to_solr['desc_metadata__name_tesim'].should == [i.name]
  end

  describe "#name_is_unique" do
    it { should validate_uniqueness_of(:name) }
  end

  describe "#check_for_association" do 
    it 'should not delete if a user is associated' do 
      user = FactoryGirl.create(:user, institution_name: i.name)
      i.destroy.should be_false
      user.destroy
    end

    it 'should not delete if a description object is associated' do
      description_object = FactoryGirl.create(:description_object, institution: i)
      i.destroy.should be_false
      description_object.destroy
    end
  end
end

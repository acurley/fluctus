namespace :fluctus do 
  desc "Setup Fluctus"
  task setup: :environment do
    desc "Creating an initial institution names 'APTrust'..."
    i = Institution.create!(name: "APTrust")

    desc "Creating required roles of 'admin', 'institutional_admin', and 'institutional_user'..."
    ['admin', 'institutional_admin', 'institutional_user'].each do |role|
      Role.create!(name: role)
    end

    desc "Create an initial Super-User for APTrust..."
    STDOUT.puts "What is your name?"
    name = STDIN.gets.strip

    STDOUT.puts "What is your Google email?"
    email = STDIN.gets.strip

    STDOUT.puts "What is your phone number?"
    phone_number = STDIN.gets.strip
   
    User.create!(name: name, email: email, phone_number: phone_number, institution_pid: i.pid,
                 role_ids: [Role.where(name: 'admin').first.id])
  end

  # Restricted only to non-production environments
  desc "Empty the database"
  task empty_db: :environment do
    if !Rails.env.production?
      [User, DescriptionObject, Institution, Role, Bag].each(&:destroy_all)
    end
  end

  desc "Run ci"
  task :travis do 
    puts "Updating Solr config"
    Rake::Task['jetty:config'].invoke
    
    require 'jettywrapper'
    jetty_params = Jettywrapper.load_config.merge({jetty_home: File.join(Rails.root , 'jetty'), startup_wait: 60 })
    
    puts "Starting Jetty"
    error = nil
    error = Jettywrapper.wrap(jetty_params) do
        Rake::Task['spec'].invoke
    end
    raise "test failures: #{error}" if error
  end

  desc "Empty DB and add dummy information"
  task populate_db: :environment do
    Rake::Task['fluctus:empty_db'].invoke
    Rake::Task['fluctus:setup'].invoke

    partner_list = [
        "Columbia University", "North Carolina State University", "Johns Hopkins University", "University of Maryland",
        "University of Michigan", "University of North Carolina at Chapel Hill", "Syracuse University" ,
        "University of Virginia", "University of Notre Dame", "Stanford University"
    ]

    puts "Creating #{partner_list.count} Institutions"
    partner_list.each_with_index do |partner, index|
      puts "== Creating number #{index+1} of #{partner_list.count}: #{partner} "
      FactoryGirl.create(:institution, name: partner)
    end

    puts "Creating Users, DescriptionObjects and Bags for each Institution"
    Institution.all.each do |institution|
      puts "Populating content for #{institution.name}"

      numUsers = rand(1..5)
      numUsers.times.each do |count|
        puts "== Creating user #{count+1} of #{numUsers} for #{institution.name}"
        FactoryGirl.create(:user, institution_pid: institution.pid)
      end

      numBags = rand(5..10)
      numBags.times.each do |count|
        puts "== Creating bag #{count+1} of #{numBags} for #{institution.name}"
        desc = FactoryGirl.create(:description_object, institution: institution)
        bag = FactoryGirl.create(:bag, description_object: desc)
        desc.save!
      end

    end
  end
end
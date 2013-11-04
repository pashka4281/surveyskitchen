task create_plans: :environment do
  puts "Creating plans..."

  Plan.create({
    name: 'free',
    price: 0.0,
    remove_survey_footer: false,
    custom_logo: false,
    surveys_count_limit: 20,
    responses_count_limit: 100
  })

  Plan.create({
    name: 'basic',
    price: 9.0,
    remove_survey_footer: true,
    custom_logo: true,
    surveys_count_limit: 20,
    responses_count_limit: 100
  })
  puts "Done"
end
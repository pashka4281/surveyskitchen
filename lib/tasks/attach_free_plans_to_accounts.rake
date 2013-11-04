task attach_free_plans_to_accounts: :environment do

  Account.all.each do |acc|
    acc.subscribe_to_plan!(Plan.find_by_name('free'))
  end
end
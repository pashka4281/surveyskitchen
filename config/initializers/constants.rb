APP_HOST = %w(test development).include?(Rails.env) ? 'http://localhost:3000' : 'http://surveyskitchen.com'
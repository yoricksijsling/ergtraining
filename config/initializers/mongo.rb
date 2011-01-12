if ENV['MONGOHQ_URL']
  MongoMapper.config = { RAILS_ENV => { 'uri' => ENV['MONGOHQ_URL'] } }
else
  MongoMapper.database = "ergtraining-#{Rails.env}"
end

Team.ensure_index :title
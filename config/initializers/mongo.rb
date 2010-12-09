MongoMapper.database = "ergtraining-#{Rails.env}"

Team.ensure_index :title
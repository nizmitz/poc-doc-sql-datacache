provider "google" {
  project = "agnes-learning-project-3"
  region  = "asia-southeast2"
}

provider "google-beta" {
  project = "agnes-learning-project-3"
  region  = "asia-southeast2"
  zone    = "asia-southeast2-a"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "google_sql_database_instance" "cache_enabled_ent_plus" {
  name             = "cache-enabled-ent-plus"
  database_version = "POSTGRES_17"
  region           = "asia-southeast2"
  deletion_protection = false

  settings {
    tier    = "db-perf-optimized-N-2"
    edition = "ENTERPRISE_PLUS"
    data_cache_config {
      data_cache_enabled = true
    }
  }
}

resource "google_sql_database_instance" "cache_enabled_ent_plus_sql_server" {
  name             = "cache-enabled-ent-plus"
  database_version = "SQLSERVER_2022_ENTERPRISE"
  region           = "asia-southeast2"
  deletion_protection = false
  root_password = random_password.password.result

  settings {
    tier    = "db-perf-optimized-N-2"
    edition = "ENTERPRISE_PLUS"
    data_cache_config {
      data_cache_enabled = true
    }
  }
}

resource "google_sql_database_instance" "cache_null_ent_plus" {
  name             = "cache-null-ent-plus"
  database_version = "POSTGRES_17"
  region           = "asia-southeast2"
  deletion_protection = false

  settings {
    tier    = "db-perf-optimized-N-2"
    edition = "ENTERPRISE_PLUS"
  }
}

resource "google_sql_database_instance" "cache_disabled_ent_plus" {
  name             = "cache-disabled-ent-plus"
  database_version = "POSTGRES_17"
  region           = "asia-southeast2"
  deletion_protection = false

  settings {
    tier    = "db-perf-optimized-N-2"
    edition = "ENTERPRISE_PLUS"
    data_cache_config {
      data_cache_enabled = false
    }
  }
}


resource "google_sql_database_instance" "cache_disabled_ent" {
  name             = "cache-disabled-ent"
  database_version = "POSTGRES_17"
  region           = "asia-southeast2"
  deletion_protection = false

  settings {
    tier    = "db-f1-micro"
    edition = "ENTERPRISE"
  }
}

output "cache_enabled_ent_plus" {
  value = {
    edition           = google_sql_database_instance.cache_enabled_ent_plus.settings.0.edition
    tier              = google_sql_database_instance.cache_enabled_ent_plus.settings.0.tier
    data_cache_config = google_sql_database_instance.cache_enabled_ent_plus.settings.0.data_cache_config
  }
 }

output "cache_enabled_ent_plus_sql_server" {
  value = {
    edition           = google_sql_database_instance.cache_enabled_ent_plus_sql_server.settings.0.edition
    tier              = google_sql_database_instance.cache_enabled_ent_plus_sql_server.settings.0.tier
    data_cache_config = google_sql_database_instance.cache_enabled_ent_plus_sql_server.settings.0.data_cache_config
  }
 }

output "cache_null_ent_plus" {
  value = {
    edition           = google_sql_database_instance.cache_null_ent_plus.settings.0.edition
    tier              = google_sql_database_instance.cache_null_ent_plus.settings.0.tier
    data_cache_config = google_sql_database_instance.cache_null_ent_plus.settings.0.data_cache_config
  }
}

output "cache_disabled_ent_plus" {
  value = {
    edition           = google_sql_database_instance.cache_disabled_ent_plus.settings.0.edition
    tier              = google_sql_database_instance.cache_disabled_ent_plus.settings.0.tier
    data_cache_config = google_sql_database_instance.cache_disabled_ent_plus.settings.0.data_cache_config
  }
}

output "cache_disabled_ent" {
  value = {
    edition           = google_sql_database_instance.cache_disabled_ent.settings.0.edition
    tier              = google_sql_database_instance.cache_disabled_ent.settings.0.tier
    data_cache_config = google_sql_database_instance.cache_disabled_ent.settings.0.data_cache_config
  }
}

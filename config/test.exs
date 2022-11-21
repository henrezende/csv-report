import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :csv_report, CsvReport.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "db",
  database: "csv_report_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :csv_report, CsvReportWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "gcrvLPwubUcV3cWAmNDMct+Ah8qbtqUNHrclyqT9P0GcVEj7DE0KIcZhOzp1426a",
  server: false

# In test we don't send emails.
config :csv_report, CsvReport.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

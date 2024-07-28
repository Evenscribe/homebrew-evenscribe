class EvenscribeCollectorAT01 < Formula
  desc "Log Collector for Evenscribe Logging Infra"
  homepage "https://www.evenscribe.com"
  url "https://github.com/Evenscribe/evenscribe-collector.git", branch: "main"
  version "0.1"
  license "Apache-2.0"

  depends_on "cmake" => :build
  depends_on "postgresql@14" => :build
  depends_on macos: [:sonoma, :or_newer]
  uses_from_macos "openssl"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
      Add the following to your ~/.evenscriberc file:
      {
        "host": "YOUR_DB_HOST",
        "port": "YOUR_DB_PORT",
        "user": "YOUR_DB_USERNAME",
        "password": "YOUR_DB_PASSWORD",
        "dbname": "YOUR_DB_NAME",
        "database_kind": "clickhouse || postgres"
      }
    EOS
  end

  test do
    system "false"
  end
end

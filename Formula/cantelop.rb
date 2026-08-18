# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and harness releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.1.0-rc.12"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.12/cantelop_0.1.0-rc.12_darwin_amd64.tar.gz"
      sha256 "cd5aae3cdd9e742123cfc882ea2e15d36101a7fabc4733254314fa293f37cbfe"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.12/cantelop_0.1.0-rc.12_darwin_arm64.tar.gz"
      sha256 "9688f1f24e29237785b44e180f2b878d36e5032d5bbe32ce29883258e0158747"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.12/cantelop_0.1.0-rc.12_linux_amd64.tar.gz"
      sha256 "de16f72538cfcb9f7b8e23165f4c79e284fb1a69f48796f98c2d1f9fb46fd801"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.12/cantelop_0.1.0-rc.12_linux_arm64.tar.gz"
      sha256 "3cededcd3ad81cd4361e1d5450d17562bdaff98fb31c26342ac15aa70946b166"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

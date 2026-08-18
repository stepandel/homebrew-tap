# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and harness releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.1.0-rc.11"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.11/cantelop_0.1.0-rc.11_darwin_amd64.tar.gz"
      sha256 "09bb28a1382fb27779084abf60c3f9b21f87d5f0fc7787f7992cd219962befce"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.11/cantelop_0.1.0-rc.11_darwin_arm64.tar.gz"
      sha256 "4c805416cc39ac5f3fbcbb9832ce640e5c8446a474044e0eb5e5a9f0795571f5"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.11/cantelop_0.1.0-rc.11_linux_amd64.tar.gz"
      sha256 "fe6470ae6d926c5651a3854f6f27b53c6d38efe358bcc1ad41b83f05e37ddb4a"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.11/cantelop_0.1.0-rc.11_linux_arm64.tar.gz"
      sha256 "7776a0f4720a58e2c40d03c633525a0ee6cd837d4de4be4b49c4603082a6aa41"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

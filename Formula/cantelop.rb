# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.11.4"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.4/cantelop_0.11.4_darwin_amd64.tar.gz"
      sha256 "dd57c8a2509f66d2cf71923c2edfa33f72498a7924e0aea2099be0888afc747a"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.4/cantelop_0.11.4_darwin_arm64.tar.gz"
      sha256 "dba7e8f05a41fecf59beef5c8a93abf71f7ce3f32188c475e69ed3e2393b7c14"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.4/cantelop_0.11.4_linux_amd64.tar.gz"
      sha256 "b5dfa0930fe574d692c9070aeb60dc9a1309858e565b549b6645289924abe4d2"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.4/cantelop_0.11.4_linux_arm64.tar.gz"
      sha256 "12f6ae5706fdb81d0fa55e4370a57105e8900752aed5d767162bb796ff5fe470"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

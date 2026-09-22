# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.11.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.2/cantelop_0.11.2_darwin_amd64.tar.gz"
      sha256 "c679b46be7a76750e69325a2a438a7e08b04c617213fc2258471f380f5be0f9b"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.2/cantelop_0.11.2_darwin_arm64.tar.gz"
      sha256 "fea0e41a8a3de5e9e5e1ec404fb75f3a74eafc3a72cf4377c8062b5f657b5c48"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.2/cantelop_0.11.2_linux_amd64.tar.gz"
      sha256 "170ed58a9eedd0fe94092bc084b883f8856460c6308e18a888ffa3034da71dd4"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.2/cantelop_0.11.2_linux_arm64.tar.gz"
      sha256 "5e680cb718810d53450ac5f82ef71452685dd852160dbecf6a77a67f33714012"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

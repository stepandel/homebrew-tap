# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.3.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.0/cantelop_0.3.0_darwin_amd64.tar.gz"
      sha256 "1137db18521fe684782281a391e57adad9fda61f56a16cf1550819bca308504c"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.0/cantelop_0.3.0_darwin_arm64.tar.gz"
      sha256 "321d411caa00e0f4bdb0c34fc2b7d88770bac79f87cbed40e1471c1a10e17743"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.0/cantelop_0.3.0_linux_amd64.tar.gz"
      sha256 "abea409cf85822ab7f2c057a59164217cf3e83bff32b8604521f1598ded46b46"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.0/cantelop_0.3.0_linux_arm64.tar.gz"
      sha256 "ef16fd38ee1acd1e118fa3f0069d178d1971104afede294daca05c62af7d17d0"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

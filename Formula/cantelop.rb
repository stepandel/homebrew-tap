# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.16.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.16.2/cantelop_0.16.2_darwin_amd64.tar.gz"
      sha256 "7592070ef6d05fd07b4befde4d9537129b0584ac687737f8f72af7f6dd23f6a4"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.16.2/cantelop_0.16.2_darwin_arm64.tar.gz"
      sha256 "a34d91b8106261c2b6bcf133997a1bbfb0e1172f85a617d546368426549fc83f"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.16.2/cantelop_0.16.2_linux_amd64.tar.gz"
      sha256 "b05bc066af27f60c6e93958ac15a559e57dc15fab3cba71a4c1888e0ed119574"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.16.2/cantelop_0.16.2_linux_arm64.tar.gz"
      sha256 "db1679a662c8d9d384fa496561e7ec2216e159826654ebffad6b70ed74540822"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

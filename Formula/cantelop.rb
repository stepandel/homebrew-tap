# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.7.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.7.0/cantelop_0.7.0_darwin_amd64.tar.gz"
      sha256 "5c9db024a6159adf54fba43b2df2316a28095aefa84bc9b2eff9236ac6a0ed5b"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.7.0/cantelop_0.7.0_darwin_arm64.tar.gz"
      sha256 "80ddab539b483793e95e83caa0f6c9043a59c4d073d22618b081f6fc007f1a57"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.7.0/cantelop_0.7.0_linux_amd64.tar.gz"
      sha256 "2ad2a3fd9d70cf3914a500cf7621f5c4d2acb09ff939f23f9e70891dfe9151fb"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.7.0/cantelop_0.7.0_linux_arm64.tar.gz"
      sha256 "6cddef62583ca90c5d08e8909c3075333c528341aec455ba31129ed94179aac7"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

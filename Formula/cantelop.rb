# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and harness releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.1.0-rc.5"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.5/cantelop_0.1.0-rc.5_darwin_amd64.tar.gz"
      sha256 "cf7b6b4f487c04fba4af29698f72c2f828440db8f7e3945dd9d518ba53ed64c9"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.5/cantelop_0.1.0-rc.5_darwin_arm64.tar.gz"
      sha256 "2af7f8937c78a16b0846f17ca1b5341ff35550aa8f23cb1fbe09ab10d65ae178"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.5/cantelop_0.1.0-rc.5_linux_amd64.tar.gz"
      sha256 "56ecb82702238d07a52ccf4c652884f50c918af6e25bce0b44387e15313cdb8d"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.5/cantelop_0.1.0-rc.5_linux_arm64.tar.gz"
      sha256 "32aa5b696168de75208ef08eea9ce768d04acd9a7f9de366f77fd865d4e89b12"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

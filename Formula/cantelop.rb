# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.6.0/cantelop_0.6.0_darwin_amd64.tar.gz"
      sha256 "32bb2ba848086265b3873b12de12fee4c1d08b9dd01dcf30931ff15539b83e5b"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.6.0/cantelop_0.6.0_darwin_arm64.tar.gz"
      sha256 "756cdda72bd8d1b9a63cd7ea2ab00835c555e688b2586cc64a807f40152ab6bb"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.6.0/cantelop_0.6.0_linux_amd64.tar.gz"
      sha256 "4fb1a967668143782ede1c9a8299c7bb7950c463ec9676eda99eb6454dc811e6"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.6.0/cantelop_0.6.0_linux_arm64.tar.gz"
      sha256 "16a812fa16c200735ca9d0112a02dafe8dc686a923fe52e18f7dcb89ceeac28e"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

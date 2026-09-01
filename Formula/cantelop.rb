# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.3.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.2/cantelop_0.3.2_darwin_amd64.tar.gz"
      sha256 "b45b1d55146eb0d6092e279d06280de147baba3a86f2f64b4226c8e85917a61c"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.2/cantelop_0.3.2_darwin_arm64.tar.gz"
      sha256 "bdfda8fbf4faafa29e1e504c984c419d0f77b076827b32198a6d17e999aebd1b"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.2/cantelop_0.3.2_linux_amd64.tar.gz"
      sha256 "8b1942ec7d7387bca3ca1682d765f7363fcf5c74886fa369892f6ddb9dc8407a"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.2/cantelop_0.3.2_linux_arm64.tar.gz"
      sha256 "5e9c3a3286d27020ceec39fbff22d2eef1c3a45b90600487d05f9170ec0bca42"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

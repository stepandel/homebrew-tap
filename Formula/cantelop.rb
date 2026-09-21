# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.9.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.9.0/cantelop_0.9.0_darwin_amd64.tar.gz"
      sha256 "d197a79649f703ddcebc86935e716996718caa588de95216be848d4b1a414af4"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.9.0/cantelop_0.9.0_darwin_arm64.tar.gz"
      sha256 "01ccf91a24a132563dcc5e2a2965adcc62653aa473eacbc492be3f23fd833a6c"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.9.0/cantelop_0.9.0_linux_amd64.tar.gz"
      sha256 "acd26a63550ba6694ca4e9cf02c64e9043f0c8bb30eb850d7fc4e16023e2224c"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.9.0/cantelop_0.9.0_linux_arm64.tar.gz"
      sha256 "ac39e0b690674381934244c8bf4927f666a2976b921f8db7c781df804c36d624"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

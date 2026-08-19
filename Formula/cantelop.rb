# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and harness releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.2.0/cantelop_0.2.0_darwin_amd64.tar.gz"
      sha256 "ccfac39242324dafbd9c6271fd57418243f4daf20cb4d13cd989543e27360655"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.2.0/cantelop_0.2.0_darwin_arm64.tar.gz"
      sha256 "efe2483180ea52980d7bd59729f5d5a1f871ac1860318b730ba3c3342e3f523d"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.2.0/cantelop_0.2.0_linux_amd64.tar.gz"
      sha256 "dcc4ba5649392180983812dafa52c5ea1aef6eca434332eea3c9279dd49ca92d"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.2.0/cantelop_0.2.0_linux_arm64.tar.gz"
      sha256 "68276e154ca34940de3463526eaf276800edc0c868be412f66435d9b7fbe4f68"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

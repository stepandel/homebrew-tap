# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.6.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.6.1/cantelop_0.6.1_darwin_amd64.tar.gz"
      sha256 "9361a3cbb59bb5f7256a35c4f4bff8147adc8f65c9631c98cd8102daf74535f4"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.6.1/cantelop_0.6.1_darwin_arm64.tar.gz"
      sha256 "1a0fdbb9bef65cd3e71a33bfc225cfb2c083da36db6df4642a3c32d26084f8af"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.6.1/cantelop_0.6.1_linux_amd64.tar.gz"
      sha256 "3c3b29e324ae091427f234c7723212a53c648ff407928c97c83ceb59ba0ca63c"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.6.1/cantelop_0.6.1_linux_arm64.tar.gz"
      sha256 "554fad056a75a84f6f6c82179b1cc9609609f361bcc4f5d821873618f8c87d3b"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

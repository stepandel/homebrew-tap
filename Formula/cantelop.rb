# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.8.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.1/cantelop_0.8.1_darwin_amd64.tar.gz"
      sha256 "8ae75f8c5c581ba6bdde946d4c59c4a09e777882a803bc3e6798031ac9f36aba"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.1/cantelop_0.8.1_darwin_arm64.tar.gz"
      sha256 "9bedd38f53bea258ec80d7648991605a23d8323bb862afcbff1e1ae36eba15b6"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.1/cantelop_0.8.1_linux_amd64.tar.gz"
      sha256 "59a80b3bacfd22b56347732d6ea0d5311ee7d3f5128cc8f7aea8b8bba30e2671"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.1/cantelop_0.8.1_linux_arm64.tar.gz"
      sha256 "6406eee978a25cc29eed601c073fae0a73be64a8fa03144d86110cd3c0b8ef8b"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.17.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.17.1/cantelop_0.17.1_darwin_amd64.tar.gz"
      sha256 "569d37c5283f81e053d86db0b1d4a1cd544309b42a7c144cb34eb67f4ba47aa2"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.17.1/cantelop_0.17.1_darwin_arm64.tar.gz"
      sha256 "bfb583d356df45b7c50766a3a67794a8b56a6c249da295e54c91d14640650e64"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.17.1/cantelop_0.17.1_linux_amd64.tar.gz"
      sha256 "2264582901d0e3f5223e58a2d46f24ceaaf821fd8512e6452fce7971a359c39f"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.17.1/cantelop_0.17.1_linux_arm64.tar.gz"
      sha256 "d1f6d263610555726a62356235dd62cd44c08841c033432985e915b36601a6e0"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

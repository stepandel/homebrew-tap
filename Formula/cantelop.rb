# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.15.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.0/cantelop_0.15.0_darwin_amd64.tar.gz"
      sha256 "b63e33016b045702b7883a1793a37ef75bd9a5ea5a8606f629f8ee4b712e4294"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.0/cantelop_0.15.0_darwin_arm64.tar.gz"
      sha256 "d3e2f8c16822684e8c31859340542e95dcc76ba3601f760ef3213d5fa4607e2c"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.0/cantelop_0.15.0_linux_amd64.tar.gz"
      sha256 "270dc1c784409e850b879e8a925a716cb1a1cd521bfc8f7dd3ad36a7348e4471"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.0/cantelop_0.15.0_linux_arm64.tar.gz"
      sha256 "ecb8889cc06b0bef8cc6aabc93bcbb970591631c7fcd6defe62b09569f1aa0e1"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

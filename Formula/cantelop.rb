# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and harness releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.1.0-rc.13"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.13/cantelop_0.1.0-rc.13_darwin_amd64.tar.gz"
      sha256 "80bc31ec76bb70bfeb1b8e853199ce30f2ba9511a11f22079305d9fe9702e173"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.13/cantelop_0.1.0-rc.13_darwin_arm64.tar.gz"
      sha256 "ed00929bad795af297ebc7adfd234b54f43e180130301b84ea7cb82b52c46793"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.13/cantelop_0.1.0-rc.13_linux_amd64.tar.gz"
      sha256 "4d0c91e76c8cceaaf95d22aae014b5f341ec18b2fd63160735da31bd70dc8b46"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.13/cantelop_0.1.0-rc.13_linux_arm64.tar.gz"
      sha256 "351e3f59119efedab680b1697b4075b068cc757a238363a16b83c323225ca666"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end

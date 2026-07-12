class Chunder < Formula
  desc "Download, search, clip, and even WATCH YouTube videos in your terminal"
  homepage "https://github.com/blyncnov/chunder"
  url "https://github.com/blyncnov/chunder/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "9af7c272fcfd794a30a6084279ea7be7c16275921149604824d9adfcdd4ebcfd"
  license "MIT"
  head "https://github.com/blyncnov/chunder.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/blyncnov/chunder/cmd.version=v#{version}
      -X github.com/blyncnov/chunder/cmd.commit=homebrew
    ].join(" ")
    system "go", "build", *std_go_args(ldflags: ldflags)

    generate_completions_from_executable(bin/"chunder", "completion")
  end

  def caveats
    <<~EOS
      ffmpeg unlocks 1080p+ downloads, clips, mp3 conversion, subtitle
      embedding, and `chunder watch`:
        brew install ffmpeg
    EOS
  end

  test do
    assert_match "chunder v#{version}", shell_output("#{bin}/chunder version")
  end
end

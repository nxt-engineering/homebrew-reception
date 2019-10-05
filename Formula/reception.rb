class Reception < Formula
  desc "Entry page & reverse proxy for all your docker-compose projects."
  homepage "https://github.com/nxt-engineering/reception"
  url "https://github.com/nxt-engineering/reception/archive/2.1.0.tar.gz"
  sha256 "444dc4bee3967befa181eadd0574095dedb3de86cf85fbcad56df6d1a7cbe884"
  head "https://github.com/nxt-engineering/reception.git"
  revision 0

  depends_on "go" => :build
  depends_on "git" => :build
  depends_on "docker" => :optional
  depends_on "docker-compose" => :optional

  bottle do
    cellar :any
    root_url "https://github.com/nxt-engineering/homebrew-reception/releases/download/v2.1.0"
    sha256 "28b73ddf0187d25e5d57c844f877be16f0fd626efad6f52d6c272b1c90db8a25" => :mojave
    sha256 "604dbb8596c93fc9d002f5f9e8f476287a71b5f23e87a8716f2638edefa39441" => :high_sierra
  end

  def install
    mkdir_p buildpath/"src/github.com/nxt-engineering"
    ln_sf buildpath, buildpath/"src/github.com/nxt-engineering/reception"

    ENV["GOPATH"] = "#{buildpath}/.gopath"
    ENV["PATH"] = "#{buildpath}/.gopath/bin:#{ENV["PATH"]}"

    system "go", "get", "github.com/GeertJohan/go.rice/rice@v1.0.0"
    system "make", "build"

    bin.install "reception"
  end

  def caveats
    <<~EOS
      Read https://github.com/nxt-engineering/reception#macos to learn how to complete the setup!

      It's important to launch reception as root. So if you use "brew services", use force:

          sudo brew services start reception

      Now type http://reception.docker into your browser and have fun.
    EOS
  end

  plist_options :manual => "sudo reception"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>ch.nine.reception</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{HOMEBREW_PREFIX}/bin/reception</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>WorkingDirectory</key>
      <string>#{var}/run/</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/reception.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/reception.log</string>
    </dict>
    </plist>
    EOS
  end

  test do
    system bin/"reception", "-v"
  end
end

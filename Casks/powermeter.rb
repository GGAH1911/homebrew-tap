cask "powermeter" do
  version "1.5.3"
  sha256 "1406ebf5e922ef50866c06c7ccbc3f32e158843fa8bcbca5c969063e7675d929"

  url "https://github.com/GGAH1911/PowerMeter/releases/download/v#{version}/PowerMeter-v#{version}-arm64.zip",
      verified: "github.com/GGAH1911/PowerMeter/"
  name "PowerMeter"
  desc "Menu bar power flow monitor and battery charge limiter"
  homepage "https://github.com/GGAH1911/PowerMeter"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "PowerMeter.app"

  # Ad-hoc signed and not notarized, so Gatekeeper would refuse to launch it
  # while the download carries a quarantine flag.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/PowerMeter.app"],
                   sudo: false
  end

  uninstall quit: "local.powermeter"

  zap trash: [
    "~/Library/Preferences/local.powermeter.plist",
    "~/Library/Saved Application State/local.powermeter.savedState",
  ]
end

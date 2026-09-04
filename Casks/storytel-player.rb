cask "storytel-player" do
  arch arm: "arm64", intel: "722a4ab4749e6cf155450489d8483e4a34f095c3dceb6c93ca6c775496ec9ec6"

  version "1.4.0"
  sha256 arm:   "987cea2fcac10f026316ba589faa3460a464db43818c3bd4ee96dc848548f36d",
         intel: "722a4ab4749e6cf155450489d8483e4a34f095c3dceb6c93ca6c775496ec9ec6"

  url "https://github.com/debba/storytel-player/releases/download/v#{version}/Storytel-Player-#{version}-mac-#{arch}.dmg"
  name "Storytel Player"
  desc "Unofficial Storytel Player for Desktop"
  homepage "https://github.com/debba/storytel-player"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  auto_updates true
  depends_on macos: ">= :monterey"

  app "Storytel Player.app"

  postflight do
    system_command "xattr",
                    args: [
                        "-c", "#{appdir}/Storytel Player.app"
                    ]
  end

  zap trash: [
    "~/Library/Application Support/storytel-player",
    "~/Library/Caches/storytel-player",
    "~/Library/Logs/storytel-player",
    "~/Library/Preferences/com.debba.storytel-player.plist",
    "~/Library/Saved Application State/com.debba.storytel-player.savedState",
  ]
end

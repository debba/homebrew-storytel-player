cask "storytel-player" do
  arch arm: "arm64", intel: "3c4ba0ee13be8f8eb48e7ea47709f00a0668c32a3affe552f31967bf7548dd46"

  version "1.4.1"
  sha256 arm:   "c9e78dbe42281156e9eb7aec21e3f43c5fc2f66a999d5f0fa129b29c6746246b",
         intel: "3c4ba0ee13be8f8eb48e7ea47709f00a0668c32a3affe552f31967bf7548dd46"

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

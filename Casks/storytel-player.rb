cask "storytel-player" do
  arch arm: "arm64", intel: "49e77a3753c10bf30e06484729a5493cdf24154db2bbeb1698338383d31e01f7"

  version "1.2.14"
  sha256 arm:   "6c95c1e80b8bafe79139fb918426a289053db677037b4d630ad966d06e55cb72",
         intel: "49e77a3753c10bf30e06484729a5493cdf24154db2bbeb1698338383d31e01f7"

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

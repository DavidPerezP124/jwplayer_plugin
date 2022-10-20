package jwplayer.jwplayer

import com.jwplayer.pub.api.configuration.PlayerConfig
import com.jwplayer.pub.api.media.playlists.PlaylistItem
import org.json.JSONObject

class ConfigurationBuilder {

    fun normalizeAdConfig(config: JSONObject) : JSONObject {
        val advertising: JSONObject = config.getJSONObject("advertising")
        if (advertising.has("client")) {
            if ((advertising["client"] as String).contains("googima")) {
                advertising.put("client", "GOOGIMA")
            } else if ((advertising["client"] as String).contains("dai")) {
                advertising.put("client", "IMA_DAI")
            } else if ((advertising["client"] as String).contains("vast")) {
                advertising.put("client", "VAST")
            } else if ((advertising["client"] as String).contains("freewheel")) {
                advertising.put("client", "FREEWHEEL")
            }
            config.put("advertising", advertising)
        }
        return config
    }

    private fun getFile(config: JSONObject): String {
        return config.getString("file")
    }

    private fun getPlaylist(config: JSONObject): List<PlaylistItem> {
        var array = mutableListOf<PlaylistItem>()
        return array
    }

    fun toPlayerConfig(config: JSONObject): PlayerConfig {
        var builder = PlayerConfig.Builder()
        builder.file(getFile(config))
        if (config.has("playlist")) {
            builder.playlist(getPlaylist(config))
        }
        builder.useTextureView(true)
        return builder.build()
    }
}
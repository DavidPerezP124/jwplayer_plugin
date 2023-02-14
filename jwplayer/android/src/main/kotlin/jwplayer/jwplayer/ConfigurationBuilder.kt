package jwplayer.jwplayer

import com.jwplayer.pub.api.configuration.PlayerConfig
import com.jwplayer.pub.api.media.ads.AdBreak
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

    private fun getPlaylistItem(config: JSONObject): PlaylistItem {
        var builder = PlaylistItem.Builder()
        // Set all string based values
        if (config.has("file")) builder.file(config.getString("file"))
        if (config.has("title")) builder.title(config.getString("title"))
        if (config.has("description")) builder.description(config.getString("description"))
        if (config.has("feedid")) builder.feedId(config.getString("feedid"))
        if (config.has("image")) builder.image(config.getString("image"))
        if (config.has("mediaid")) builder.mediaId(config.getString("mediaid"))
        // Set Duration
        if (config.has("duration")) builder.duration(config.getInt("duration"))
        // Get the Ad Schedule
        if (config.has("adSchedule")) builder.adSchedule(getAdSchedule(config))


            .externalMetadata()
            .httpHeaders()
            .imaDaiSettings()
            .recommendations()
            .startTime()
            .sources()
            .tracks()

        return  builder.build()
    }

    private fun getAdSchedule(config: JSONObject): List<AdBreak> {
        val schedule = config.getJSONObject("adschedule")
        var adBreaks = mutableList<AdBreak>

        (0 until schedule.length()).forEach {
            var tag = schedule.getJSONObject(it)
            var builder = AdBreak.Builder()
                .adType()
        }

        return adBreaks
    }



    fun toPlayerConfig(config: JSONObject): PlayerConfig {
        var builder = PlayerConfig.Builder()
        // Retrieve the file if a file exists
        if (config.has("file")) builder.file(getFile(config))
        // Retrieve the playlist if it exists
        if (config.has("playlist")) builder.playlist(getPlaylist(config))
        // Retrieve the advertising config if it exits
        if (config.has("advertising")) builder.advertisingConfig()
    
        builder.useTextureView(true)
        return builder.build()
    }
}
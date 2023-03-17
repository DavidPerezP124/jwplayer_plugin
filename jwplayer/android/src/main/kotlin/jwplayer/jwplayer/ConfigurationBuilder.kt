package jwplayer.jwplayer

import com.jwplayer.pub.api.configuration.PlayerConfig
import com.jwplayer.pub.api.configuration.ads.AdvertisingConfig
import com.jwplayer.pub.api.configuration.ads.VastAdvertisingConfig
import com.jwplayer.pub.api.configuration.ads.VmapAdvertisingConfig
import com.jwplayer.pub.api.configuration.ads.ima.ImaAdvertisingConfig
import com.jwplayer.pub.api.configuration.ads.dai.ImaDaiAdvertisingConfig

import com.jwplayer.pub.api.media.ads.AdBreak
import com.jwplayer.pub.api.media.playlists.ExternalMetadata
import com.jwplayer.pub.api.media.playlists.PlaylistItem
import org.json.JSONObject

class ConfigurationBuilder {

    private fun extractClientBuilder(config: JSONObject): AdvertisingConfig.Builder {
        val advertising: JSONObject = config.getJSONObject("advertising")
        var adConfig: AdvertisingConfig.Builder = VastAdvertisingConfig.Builder()

        if (advertising.has("client")) {
            val client = advertising.getString("client")
            with(client) {
                when {
                    contains("vast") -> adConfig = VastAdvertisingConfig.Builder()
                    contains("vmap") -> adConfig = VmapAdvertisingConfig.Builder()
                    contains("googima") -> adConfig = ImaAdvertisingConfig.Builder()
                    contains("dai") -> adConfig = ImaDaiAdvertisingConfig.Builder()
                    else -> {}
                }
            }
        }
        return adConfig
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
        // If an Ad Schedule is specified,  parse and set the schedule
        if (config.has("adSchedule")) builder.adSchedule(getAdSchedule(config))
        // If external metadata is specified, parse and set the external metadata
        if (config.has("externalMetadata")) builder.externalMetadata(getExternalMetadata(config))
            .recommendations()
            .startTime()
            .sources()
            .tracks()

        return builder.build()
    }

    private fun getExternalMetadata(config: JSONObject): List<ExternalMetadata> {
        var metadata = mutableList<ExternalMetadata>
        val configMetadata = config.getJSONObject("externalMetadata")
        (0 until configMetadata.length()).forEach {
            val metadataJSON = configMetadata.getJSONObject(it)
            val newMetadata = ExternalMetadata(
                configMetadata.getInt(it),
                configMetadata.getDouble("startTime"),
                configMetadata.getDouble("endTime")
            )
            metadata.add(newMetadata)
        }
        return metadata
    }

    private fun getAdvertising(config: JSONObject): AdvertisingConfig {
        var builder = extractClientBuilder(config)
        when (builder) {
            is VmapAdvertisingConfig -> {

            }
            else -> {}
        }
        return builder.build()
    }

    private fun getAdSchedule(config: JSONObject): List<AdBreak> {
        val schedule = config.getJSONObject("schedule")
        var adBreaks = mutableList<AdBreak>

        (0 until schedule.length()).forEach {
            var adBreak = schedule.getJSONObject(it)
            var builder = AdBreak.Builder()
                    .tag(adBreak.getString("tag"))
                    .offset(adBreak.getString("offset"))
            if (adBreak.has("customParams") && adBreak.get("customParams") is Map<*, *>) {
                builder.customParams(adBreak.get("customParams") as Map<String, String>)
            }
            val result = builder.build()
            adBreaks = append(adBreaks, result)
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
        if (config.has("advertising")) builder.advertisingConfig(getAdvertising(config))

        builder.useTextureView(true)
        return builder.build()
    }
}
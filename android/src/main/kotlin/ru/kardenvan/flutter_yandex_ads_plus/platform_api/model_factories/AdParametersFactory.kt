package ru.kardenvan.flutter_yandex_ads_plus.platform_api.model_factories

import android.location.Location
import com.yandex.mobile.ads.common.AdTheme
import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters


class AdParametersFactory {
    companion object Factory {
        fun fromMap(map: Map<*, *>): AdParameters {
            var contextTags: MutableList<String>? = null
            val rawContextTags = map["context_tags"]

            if (rawContextTags is List<*>) {
                contextTags = mutableListOf()

                for (tag in rawContextTags) {
                    if (tag is String) {
                        contextTags.add(tag)
                    }
                }
            }

            var theme: AdTheme? = null
            val rawTheme = map["preferred_theme"]

            if (rawTheme is String) {
                theme = AdThemeFactory.fromString(rawTheme)
            }

            var location: Location? = null
            val rawLocation = map["location"]

            if (rawLocation is Map<*,*>) {
                location = LocationFactory.fromMap(rawLocation)
            }

            var customParams: Map<String, String>? = null
            val rawCustomParams = map["custom"]

            if (rawCustomParams is Map<*,*>) {
                customParams = buildCustomParameters(rawCustomParams)
            }

            return AdParameters(
                age = map["age"] as String?,
                biddingData = map["bidding_data"] as String?,
                contextQuery = map["context_query"] as String?,
                contextTags = contextTags,
                gender = map["gender"] as String?,
                preferredTheme = theme,
                location = location,
                custom = customParams,
            )
        }

        private fun buildCustomParameters(rawParams: Map<*, *>): Map<String, String> {
            val customParams = mutableMapOf<String, String>()

            for (param in rawParams) {
                val key = param.key
                val value = param.value

                if (key is String && value is String) {
                    customParams[key] = value
                }
            }

            return customParams
        }
    }

    private class AdThemeFactory {
        companion object Factory {
            fun fromString(value: String): AdTheme {
                return when (value) {
                    "dark" -> AdTheme.DARK
                    else -> AdTheme.LIGHT
                }
            }
        }
    }

    private class LocationFactory {
        companion object Factory {
            fun fromMap(map: Map<*, *>): Location {
                val location = Location("")

                val longitude = map["longitude"]
                val latitude = map["latitude"]

                if (longitude is Double) {
                    location.longitude = longitude
                }

                if (latitude is Double) {
                    location.latitude = latitude
                }

                return location
            }
        }
    }
}
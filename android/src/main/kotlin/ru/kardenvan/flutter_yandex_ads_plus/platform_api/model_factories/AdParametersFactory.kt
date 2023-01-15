package ru.kardenvan.flutter_yandex_ads_plus.platform_api.model_factories

import android.location.Location
import com.yandex.mobile.ads.common.AdTheme
import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters


class AdParametersFactory {
    companion object Factory {
        fun fromMap(map: Map<*, *>): AdParameters {
            return AdParameters(
                age = (map["age"] as Int?)?.toString(),
                biddingData = map["bidding_data"] as String?,
                contextQuery = map["context_query"] as String?,
                contextTags = parseContextTagsFromJson(map["context_tags"] as String?),
                gender = map["gender"] as String?,
                preferredTheme = parseThemeFromJson(map["preferred_theme"]),
                location = parseLocationFromJson(map["location"]),
                custom = parseCustomParametersFromJson(map["custom"]),
            )
        }

        private fun parseCustomParametersFromJson(rawParams: Any?): Map<String, String>? {
            if (rawParams !is Map<*, *>) return null

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

        private fun parseContextTagsFromJson(json: Any?): List<String>? {
            var contextTags: MutableList<String>? = null

            if (json is List<*>) {
                contextTags = mutableListOf()

                for (tag in json) {
                    if (tag is String) {
                        contextTags.add(tag)
                    }
                }
            }

            return contextTags
        }

        private fun parseThemeFromJson(json: Any?): AdTheme? {
            var theme: AdTheme? = null

            if (json is String) {
                theme = AdThemeFactory.fromString(json)
            }

            return theme
        }

        private fun parseLocationFromJson(json: Any?): Location? {
            var location: Location? = null

            if (json is Map<*,*>) {
                location = LocationFactory.fromMap(json)
            }

            return location
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
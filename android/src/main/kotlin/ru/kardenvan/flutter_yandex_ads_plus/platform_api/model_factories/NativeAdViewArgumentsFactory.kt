package ru.kardenvan.flutter_yandex_ads_plus.platform_api.model_factories

import android.graphics.Color
import android.util.Size
import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters
import ru.kardenvan.flutter_yandex_ads_plus.ads.native_yandex_ad.NativeYandexAdTextStyle
import ru.kardenvan.flutter_yandex_ads_plus.utils.ColorFactory
import ru.kardenvan.flutter_yandex_ads_plus.ads.native_yandex_ad.NativeYandexAdViewArguments
import ru.kardenvan.flutter_yandex_ads_plus.ads.native_yandex_ad.NativeYandexAdViewTheme

class NativeAdViewArgumentsFactory {
    companion object Factory {
        fun fromMap(args: Map<*, *>): NativeYandexAdViewArguments {
            val viewUid = args["uid"]
            if (viewUid !is String) {
                throw Exception(
                    "Argument \"uid\" is invalid. Given arguments: $args"
                )
            }

            val adId = args["ad_id"]
            if (adId !is String) {
                throw Exception(
                    "Arguments \"ad_id\" is invalid. Given arguments: $args"
                )
            }

            val minSize = Size(args["width"] as Int, args["height"] as Int)

            val rawParams = args["parameters"]
            var parameters: AdParameters? = null

            if (rawParams is Map<*, *>) {
                parameters = AdParametersFactory.fromMap(rawParams)
            }

            return NativeYandexAdViewArguments(
                viewUid = viewUid,
                adId = adId,
                minSize = minSize,
                theme = NativeAdViewThemeFactory.fromMap(args["theme"] as Map<*,*>),
                parameters = parameters,
            )
        }
    }

    class NativeAdViewThemeFactory {
        companion object Factory {
            fun fromMap(map: Map<*, *>): NativeYandexAdViewTheme {
                return NativeYandexAdViewTheme(
                    titleStyle = TextStyleFactory.fromMap(map["title_style"] as Map<*,*>),
                    bodyStyle = TextStyleFactory.fromMap(map["body_style"] as Map<*,*>),
                    domainStyle = TextStyleFactory.fromMap(map["domain_style"] as Map<*,*>),
                    ageStyle = TextStyleFactory.fromMap(map["age_style"] as Map<*,*>),
                    reviewCountStyle = TextStyleFactory.fromMap(map["review_count_style"] as Map<*,*>),
                    sponsoredStyle = TextStyleFactory.fromMap(map["sponsored_style"] as Map<*,*>),
                    warningStyle = TextStyleFactory.fromMap(map["warning_style"] as Map<*,*>),
                    bannerTheme = BannerThemeFactory.fromMap(map["banner_theme"] as Map<*,*>),
                    buttonTheme = ButtonThemeFactory.fromMap(map["button_theme"] as Map<*,*>),
                    ratingTheme = RatingThemeFactory.fromMap(map["rating_theme"] as Map<*,*>)
                )
            }
        }

        class BannerThemeFactory {
            companion object Factory {
                fun fromMap(map: Map<*, *>): NativeYandexAdViewTheme.BannerTheme {
                    return NativeYandexAdViewTheme.BannerTheme(
                        borderColor = ColorFactory.fromHex(map["border_color"] as String?),
                        backgroundColor = ColorFactory.fromHex(map["background_color"] as String?),
                        borderWidth = ((map["border_width"] as Double?) ?: 1).toFloat(),
                        leftPadding = ((map["left_padding"] as Double?) ?: 0).toFloat(),
                        rightPadding = ((map["right_padding"] as Double?) ?: 0).toFloat()
                    )
                }
            }
        }

        class ButtonThemeFactory {
            companion object Factory {
                fun fromMap(map: Map<*,*>): NativeYandexAdViewTheme.ButtonTheme {
                    return NativeYandexAdViewTheme.ButtonTheme(
                        backgroundColor = ColorFactory.fromHex(map["background_color"] as String?),
                        pressedBackgroundColor = ColorFactory.fromHex(map["pressed_background_color"] as String?),
                        borderColor = ColorFactory.fromHex(map["border_color"] as String?),
                        borderWidth = ((map["border_width"] as Double?) ?: 1).toFloat(),
                        textStyle = TextStyleFactory.fromMap(map["text_style"] as Map<*, *>)
                    )
                }
            }
        }

        class RatingThemeFactory {
            companion object Factory {
                fun fromMap(map: Map<*,*>): NativeYandexAdViewTheme.RatingTheme {
                    return NativeYandexAdViewTheme.RatingTheme(
                        starColor = ColorFactory.fromHex(map["star_color"] as String?),
                        progressStarColor = ColorFactory.fromHex(map["progress_star_color"] as String?),
                    )
                }
            }
        }

        class TextStyleFactory {
            companion object Factory {
                fun fromMap(map: Map<*, *>): NativeYandexAdTextStyle {
                    val hex = map["color"] as String?
                    val color: Int = if (hex != null) Color.parseColor(hex) else Color.BLACK

                    return NativeYandexAdTextStyle(
                        color = color,
                        fontSize = (map["font_size"] as Double).toFloat(),
                        fontStyle = map["font_weight"] as Int,
                        fontFamily = map["font_family"] as String?
                    )
                }
            }
        }
    }
}
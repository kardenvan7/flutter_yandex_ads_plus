package ru.kardenvan.flutter_yandex_ads_plus.platform_api

import android.graphics.Color
import android.util.Size

class PlatformApi {
    class BannerAdViewArguments(args: Any?) {
        private val defaultHeight = 320
        private val defaultWidth = 100

        private var bannerId: String
        fun getBannerId(): String { return bannerId }

        private var size: Size
        fun getBannerSize(): Size { return size }

        init {
            if (args !is Map<*, *>) {
                throw Exception("Arguments is not map. Given arguments: $args")
            }

            val params: Map<*, *> = args

            if (args["ad_id"] == null) {
                throw Exception(
                    "Arguments map doesn't contain required parameter \"ad_id\"." +
                    "Given arguments: $args"
                )
            }

            bannerId = args["ad_id"] as String

            val height: Int = params["height"] as Int? ?: defaultHeight
            val width: Int = params["width"] as Int? ?: defaultWidth

            size = Size(width, height)
        }
    }

    class NativeAdViewArguments private constructor(
        private val id: String,
        private val minSize: Size,
        private val theme: NativeAdViewTheme,
    ) {

        fun getId(): String {
            return id
        }

        fun getMinSize(): Size {
            return minSize
        }

        fun getTheme(): NativeAdViewTheme {
            return theme
        }

        companion object Factory {
            fun fromMap(args: Any?): NativeAdViewArguments {
                if (args !is Map<*, *>) {
                    throw Exception("Arguments is not map. Given arguments: $args")
                }

                val params: Map<*, *> = args

                if (args["ad_id"] == null) {
                    throw Exception(
                        "Arguments map doesn't contain required parameter \"ad_id\"." +
                                "Given arguments: $args"
                    )
                }

                val minSize = Size(params["width"] as Int, params["height"] as Int)

                return NativeAdViewArguments(
                    id = args["ad_id"] as String,
                    minSize = minSize,
                    theme = NativeAdViewTheme.fromMap(args["theme"] as Map<*,*>)
                )
            }
        }
    }
}

class TextStyle private constructor(
    private val color: Int?,
    private val fontSize: Float,
    private val fontStyle: Int,
    private val fontFamily: String?
) {
    fun getColor(): Int? { return color }
    fun getSize(): Float { return fontSize }
    fun getFontStyle(): Int { return fontStyle }
    fun getFontFamily(): String? { return fontFamily }

    companion object Factory {
        fun fromMap(map: Map<*, *>): TextStyle {
            val hex = map["color"] as String?
            val color: Int = if (hex != null) Color.parseColor(hex) else Color.BLACK

            return TextStyle(
                color = color,
                fontSize = (map["font_size"] as Double).toFloat(),
                fontStyle = map["font_weight"] as Int,
                fontFamily = map["font_family"] as String?
            )
        }
    }
}

class NativeAdViewTheme private constructor(
    private val titleStyle: TextStyle,
    private val bodyStyle: TextStyle,
    private val domainStyle: TextStyle,
    private val ageStyle: TextStyle,
    private val reviewCountStyle: TextStyle,
    private val sponsoredStyle: TextStyle,
    private val warningStyle: TextStyle,
    private val bannerTheme: BannerTheme,
    private val buttonTheme: ButtonTheme,
    private val ratingTheme: RatingTheme,
) {
    fun getTitleStyle(): TextStyle { return titleStyle }
    fun getBodyStyle(): TextStyle { return bodyStyle }
    fun getDomainStyle(): TextStyle { return domainStyle }
    fun getAgeStyle(): TextStyle { return ageStyle }
    fun getReviewCountStyle(): TextStyle { return reviewCountStyle }
    fun getSponsoredStyle(): TextStyle { return sponsoredStyle }
    fun getWarningStyle(): TextStyle { return warningStyle }
    fun getBannerTheme(): BannerTheme { return bannerTheme }
    fun getButtonTheme(): ButtonTheme { return buttonTheme }
    fun getRatingTheme(): RatingTheme { return ratingTheme }

    companion object Factory {
        fun fromMap(map: Map<*, *>): NativeAdViewTheme {
            return NativeAdViewTheme(
                titleStyle = TextStyle.fromMap(map["title_style"] as Map<*,*>),
                bodyStyle = TextStyle.fromMap(map["body_style"] as Map<*,*>),
                domainStyle = TextStyle.fromMap(map["domain_style"] as Map<*,*>),
                ageStyle = TextStyle.fromMap(map["age_style"] as Map<*,*>),
                reviewCountStyle = TextStyle.fromMap(map["review_count_style"] as Map<*,*>),
                sponsoredStyle = TextStyle.fromMap(map["sponsored_style"] as Map<*,*>),
                warningStyle = TextStyle.fromMap(map["warning_style"] as Map<*,*>),
                bannerTheme = BannerTheme.fromMap(map["banner_theme"] as Map<*,*>),
                buttonTheme = ButtonTheme.fromMap(map["button_theme"] as Map<*,*>),
                ratingTheme = RatingTheme.fromMap(map["rating_theme"] as Map<*,*>)
            )
        }
    }

    class BannerTheme private constructor(
        private val borderColor: Int?,
        private val backgroundColor: Int?,
        private val borderWidth: Float,
        private val leftPadding: Float,
        private val rightPadding: Float,
    ) {
        fun getBorderColor(): Int? {return borderColor}
        fun getBackgroundColor(): Int? {return backgroundColor}
        fun getBorderWidth(): Float {return borderWidth}
        fun getLeftPadding(): Float {return leftPadding}
        fun getRightPadding(): Float {return rightPadding}

        companion object Factory {
            fun fromMap(map: Map<*,*>): BannerTheme {
                return BannerTheme(
                    borderColor = colorOrNullFromHex(map["border_color"] as String?),
                    backgroundColor = colorOrNullFromHex(map["background_color"] as String?),
                    borderWidth = ((map["border_width"] as Double?) ?: 1).toFloat(),
                    leftPadding = ((map["left_padding"] as Double?) ?: 0).toFloat(),
                    rightPadding = ((map["right_padding"] as Double?) ?: 0).toFloat()
                )
            }

            private fun colorOrNullFromHex(hex: String?): Int? {
                return if (hex != null) Color.parseColor(hex) else null
            }
        }
    }

    class ButtonTheme private constructor(
        private val backgroundColor: Int?,
        private val pressedBackgroundColor: Int?,
        private val borderColor: Int?,
        private val borderWidth: Float,
        private val textStyle: TextStyle,
    ) {
        fun getBorderColor(): Int? {return borderColor}
        fun getBackgroundColor(): Int? {return backgroundColor}
        fun getBorderWidth(): Float {return borderWidth}
        fun getPressedBackgroundColor(): Int? {return pressedBackgroundColor}
        fun getTextTheme(): TextStyle {return textStyle}

        companion object Factory {
            fun fromMap(map: Map<*,*>): ButtonTheme {
                return ButtonTheme(
                    backgroundColor = ColorFactory.fromHex(map["background_color"] as String?),
                    pressedBackgroundColor = ColorFactory.fromHex(map["pressed_background_color"] as String?),
                    borderColor = ColorFactory.fromHex(map["border_color"] as String?),
                    borderWidth = ((map["border_width"] as Double?) ?: 1).toFloat(),
                    textStyle = TextStyle.fromMap(map["text_style"] as Map<*,*>)
                )
            }
        }
    }

    class RatingTheme private constructor(
        private val starColor: Int?,
        private val progressStarColor: Int?,
    ) {
        fun getStarColor(): Int? {return starColor}
        fun getProgressStarColor(): Int? {return progressStarColor}

        companion object Factory {
            fun fromMap(map: Map<*,*>): RatingTheme {
                return RatingTheme(
                    starColor = ColorFactory.fromHex(map["star_color"] as String?),
                    progressStarColor = ColorFactory.fromHex(map["progress_star_color"] as String?),
                )
            }
        }
    }
}

class ColorFactory {
    companion object Factory {
        fun fromHex(hex: String?): Int? {
            return if (hex != null) Color.parseColor(hex) else null
        }
    }
}
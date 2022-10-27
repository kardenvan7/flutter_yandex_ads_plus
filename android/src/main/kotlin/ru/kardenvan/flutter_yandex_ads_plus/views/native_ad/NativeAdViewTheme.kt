package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

class NativeAdViewTheme(
    private val titleStyle: NativeAdTextStyle,
    private val bodyStyle: NativeAdTextStyle,
    private val domainStyle: NativeAdTextStyle,
    private val ageStyle: NativeAdTextStyle,
    private val reviewCountStyle: NativeAdTextStyle,
    private val sponsoredStyle: NativeAdTextStyle,
    private val warningStyle: NativeAdTextStyle,
    private val bannerTheme: BannerTheme,
    private val buttonTheme: ButtonTheme,
    private val ratingTheme: RatingTheme,
) {
    fun getTitleStyle(): NativeAdTextStyle { return titleStyle }
    fun getBodyStyle(): NativeAdTextStyle { return bodyStyle }
    fun getDomainStyle(): NativeAdTextStyle { return domainStyle }
    fun getAgeStyle(): NativeAdTextStyle { return ageStyle }
    fun getReviewCountStyle(): NativeAdTextStyle { return reviewCountStyle }
    fun getSponsoredStyle(): NativeAdTextStyle { return sponsoredStyle }
    fun getWarningStyle(): NativeAdTextStyle { return warningStyle }
    fun getBannerTheme(): BannerTheme { return bannerTheme }
    fun getButtonTheme(): ButtonTheme { return buttonTheme }
    fun getRatingTheme(): RatingTheme { return ratingTheme }

    class BannerTheme constructor(
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
    }

    class ButtonTheme constructor(
        private val backgroundColor: Int?,
        private val pressedBackgroundColor: Int?,
        private val borderColor: Int?,
        private val borderWidth: Float,
        private val textStyle: NativeAdTextStyle,
    ) {
        fun getBorderColor(): Int? {return borderColor}
        fun getBackgroundColor(): Int? {return backgroundColor}
        fun getBorderWidth(): Float {return borderWidth}
        fun getPressedBackgroundColor(): Int? {return pressedBackgroundColor}
        fun getTextTheme(): NativeAdTextStyle {return textStyle}
    }

    class RatingTheme constructor(
        private val starColor: Int?,
        private val progressStarColor: Int?,
    ) {
        fun getStarColor(): Int? {return starColor}
        fun getProgressStarColor(): Int? {return progressStarColor}
    }
}
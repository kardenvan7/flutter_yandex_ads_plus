package ru.kardenvan.flutter_yandex_ads_plus.ads.native_yandex_ad

data class NativeYandexAdViewTheme(
    val titleStyle: NativeYandexAdTextStyle,
    val bodyStyle: NativeYandexAdTextStyle,
    val domainStyle: NativeYandexAdTextStyle,
    val ageStyle: NativeYandexAdTextStyle,
    val reviewCountStyle: NativeYandexAdTextStyle,
    val sponsoredStyle: NativeYandexAdTextStyle,
    val warningStyle: NativeYandexAdTextStyle,
    val bannerTheme: BannerTheme,
    val buttonTheme: ButtonTheme,
    val ratingTheme: RatingTheme,
) {
    data class BannerTheme constructor(
        val borderColor: Int?,
        val backgroundColor: Int?,
        val borderWidth: Float,
        val leftPadding: Float,
        val rightPadding: Float,
    )

    data class ButtonTheme constructor(
        val backgroundColor: Int?,
        val pressedBackgroundColor: Int?,
        val borderColor: Int?,
        val borderWidth: Float,
        val textStyle: NativeYandexAdTextStyle,
    )

    data class RatingTheme constructor(
        val starColor: Int?,
        val progressStarColor: Int?,
    )
}
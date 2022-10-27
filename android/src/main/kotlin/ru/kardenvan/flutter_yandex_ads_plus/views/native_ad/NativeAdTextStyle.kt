package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

class NativeAdTextStyle(
    private val color: Int?,
    private val fontSize: Float,
    private val fontStyle: Int,
    private val fontFamily: String?
) {
    fun getColor(): Int? { return color }
    fun getSize(): Float { return fontSize }
    fun getFontStyle(): Int { return fontStyle }
    fun getFontFamily(): String? { return fontFamily }
}
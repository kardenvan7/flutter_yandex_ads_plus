package ru.kardenvan.flutter_yandex_ads_plus.utils

import android.graphics.Color

class ColorFactory {
    companion object Factory {
        fun fromHex(hex: String?): Int? {
            return if (hex != null) Color.parseColor(hex) else null
        }
    }
}
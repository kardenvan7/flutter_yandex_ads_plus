package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

import android.graphics.Color
import com.yandex.mobile.ads.nativeads.template.HorizontalOffset
import com.yandex.mobile.ads.nativeads.template.appearance.BannerAppearance
import com.yandex.mobile.ads.nativeads.template.appearance.ButtonAppearance
import com.yandex.mobile.ads.nativeads.template.appearance.NativeTemplateAppearance
import com.yandex.mobile.ads.nativeads.template.appearance.RatingAppearance
import com.yandex.mobile.ads.nativeads.template.appearance.TextAppearance


class NativeYandexAdTemplateAppearanceFactory {
    companion object Factory {
        fun fromTheme(theme: NativeYandexAdViewTheme): NativeTemplateAppearance {
            return NativeTemplateAppearance.Builder()
                .withBannerAppearance(BannerAppearanceFactory.fromTheme(theme.bannerTheme))
                .withTitleAppearance(TextAppearanceFactory.fromTheme(theme.titleStyle))
                .withBodyAppearance(TextAppearanceFactory.fromTheme(theme.bodyStyle))
                .withDomainAppearance(TextAppearanceFactory.fromTheme(theme.domainStyle))
                .withAgeAppearance(TextAppearanceFactory.fromTheme(theme.ageStyle))
                .withSponsoredAppearance(TextAppearanceFactory.fromTheme(theme.sponsoredStyle))
                .withReviewCountAppearance(TextAppearanceFactory.fromTheme(theme.reviewCountStyle))
                .withCallToActionAppearance(ButtonAppearanceFactory.fromTheme(theme.buttonTheme))
                .withWarningAppearance(TextAppearanceFactory.fromTheme(theme.warningStyle))
                .withRatingAppearance(RatingAppearanceFactory.fromTheme(theme.ratingTheme))
                .build()
        }
    }

    class BannerAppearanceFactory {
        companion object Factory {
            fun fromTheme(bannerTheme: NativeYandexAdViewTheme.BannerTheme): BannerAppearance {
                return BannerAppearance.Builder()
                    .setBorderColor(bannerTheme.borderColor ?: 0)
                    .setBackgroundColor(bannerTheme.backgroundColor ?: 0)
                    .setBorderWidth(bannerTheme.borderWidth)
                    .setContentPadding(HorizontalOffset(bannerTheme.leftPadding, bannerTheme.rightPadding))
                    .build()
            }
        }
    }

    class TextAppearanceFactory {
        companion object Factory {
            fun fromTheme(textTheme: NativeYandexAdTextStyle): TextAppearance {
                return TextAppearance.Builder()
                    .setTextColor(textTheme.color ?: Color.BLACK)
                    .setTextSize(textTheme.fontSize)
                    .setFontStyle(textTheme.fontStyle)
                    .setFontFamilyName(textTheme.fontFamily)
                    .build()
            }
        }
    }

    class ButtonAppearanceFactory {
        companion object Factory {
            fun fromTheme(theme: NativeYandexAdViewTheme.ButtonTheme): ButtonAppearance {
                return ButtonAppearance.Builder()
                    .setNormalColor(theme.backgroundColor ?: Color.WHITE)
                    .setPressedColor(theme.pressedBackgroundColor ?: Color.GRAY)
                    .setBorderColor(theme.borderColor ?: 0)
                    .setBorderWidth(theme.borderWidth)
                    .setTextAppearance(TextAppearanceFactory.fromTheme(theme.textStyle))
                    .build()
            }
        }
    }

    class RatingAppearanceFactory {
        companion object Factory {
            fun fromTheme(theme: NativeYandexAdViewTheme.RatingTheme): RatingAppearance {
                return RatingAppearance.Builder()
                    .setBackgroundStarColor(theme.starColor ?: Color.YELLOW)
                    .setProgressStarColor(theme.progressStarColor ?: Color.GRAY)
                    .build()
            }
        }
    }
}
package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

import android.graphics.Color
import com.yandex.mobile.ads.nativeads.template.HorizontalOffset
import com.yandex.mobile.ads.nativeads.template.appearance.BannerAppearance
import com.yandex.mobile.ads.nativeads.template.appearance.ButtonAppearance
import com.yandex.mobile.ads.nativeads.template.appearance.NativeTemplateAppearance
import com.yandex.mobile.ads.nativeads.template.appearance.RatingAppearance
import com.yandex.mobile.ads.nativeads.template.appearance.TextAppearance
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.NativeAdViewTheme
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.TextStyle


class NativeTemplateAppearanceFactory {
    companion object Factory {
        fun fromTheme(theme: NativeAdViewTheme): NativeTemplateAppearance {
            return NativeTemplateAppearance.Builder()
                .withBannerAppearance(BannerAppearanceFactory.fromTheme(theme.getBannerTheme()))
                .withTitleAppearance(TextAppearanceFactory.fromTheme(theme.getTitleStyle()))
                .withBodyAppearance(TextAppearanceFactory.fromTheme(theme.getBodyStyle()))
                .withDomainAppearance(TextAppearanceFactory.fromTheme(theme.getDomainStyle()))
                .withAgeAppearance(TextAppearanceFactory.fromTheme(theme.getAgeStyle()))
                .withSponsoredAppearance(TextAppearanceFactory.fromTheme(theme.getSponsoredStyle()))
                .withReviewCountAppearance(TextAppearanceFactory.fromTheme(theme.getReviewCountStyle()))
                .withCallToActionAppearance(ButtonAppearanceFactory.fromTheme(theme.getButtonTheme()))
                .withWarningAppearance(TextAppearanceFactory.fromTheme(theme.getWarningStyle()))
                .withRatingAppearance(RatingAppearanceFactory.fromTheme(theme.getRatingTheme()))
                .build()
        }
    }

    class BannerAppearanceFactory {
        companion object Factory {
            fun fromTheme(bannerTheme: NativeAdViewTheme.BannerTheme): BannerAppearance {
                return BannerAppearance.Builder()
                    .setBorderColor(bannerTheme.getBorderColor() ?: 0)
                    .setBackgroundColor(bannerTheme.getBackgroundColor() ?: 0)
                    .setBorderWidth(bannerTheme.getBorderWidth())
                    .setContentPadding(HorizontalOffset(bannerTheme.getLeftPadding(), bannerTheme.getRightPadding()))
                    .build()
            }
        }
    }

    class TextAppearanceFactory {
        companion object Factory {
            fun fromTheme(textTheme: TextStyle): TextAppearance {
                return TextAppearance.Builder()
                    .setTextColor(textTheme.getColor() ?: Color.BLACK)
                    .setTextSize(textTheme.getSize())
                    .setFontStyle(textTheme.getFontStyle())
                    .setFontFamilyName(textTheme.getFontFamily())
                    .build()
            }
        }
    }

    class ButtonAppearanceFactory {
        companion object Factory {
            fun fromTheme(theme: NativeAdViewTheme.ButtonTheme): ButtonAppearance {
                return ButtonAppearance.Builder()
                    .setNormalColor(theme.getBackgroundColor() ?: Color.WHITE)
                    .setPressedColor(theme.getPressedBackgroundColor() ?: Color.GRAY)
                    .setBorderColor(theme.getBorderColor() ?: 0)
                    .setBorderWidth(theme.getBorderWidth())
                    .setTextAppearance(TextAppearanceFactory.fromTheme(theme.getTextTheme()))
                    .build()
            }
        }
    }

    class RatingAppearanceFactory {
        companion object Factory {
            fun fromTheme(theme: NativeAdViewTheme.RatingTheme): RatingAppearance {
                return RatingAppearance.Builder()
                    .setBackgroundStarColor(theme.getStarColor() ?: Color.YELLOW)
                    .setProgressStarColor(theme.getProgressStarColor() ?: Color.GRAY)
                    .build()
            }
        }
    }
}
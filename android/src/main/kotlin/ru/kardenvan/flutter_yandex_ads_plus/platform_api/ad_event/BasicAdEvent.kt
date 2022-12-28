package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event

data class BasicAdEvent constructor(
    private val viewUid: String,
    private val type: Type,
    private val parameters: Map<String, Any?>? = null,
): AdEvent() {
    override fun toMap(): Map<String, Any?> {
        return mapOf(
            "view_uid" to viewUid,
            "type" to type.value,
            "parameters" to parameters,
        )
    }

    enum class Type constructor(
        val value: String
    ) {
        ON_AD_LOADED("onAdLoaded"),
        ON_AD_FAILED_TO_LOAD("onAdFailedToLoad"),
        ON_IMPRESSION("onImpression"),
        ON_LEFT_APPLICATION("onLeftApplication"),
        ON_RETURNED_TO_APPLICATION("onReturnedToApplication"),
        ON_AD_CLICKED("onAdClicked");
    }
}
package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event

data class InterstitialAdEvent constructor(
    private val viewUid: String,
    private val type: Type,
    private val parameters: Map<String, Any?>? = null,
): AdEvent() {

    enum class Type constructor(
        val value: String
    ) {
        ON_AD_SHOWN("onAdShown"),
        ON_AD_DISMISSED("onAdDismissed");
    }

    override fun toMap(): Map<*, *> {
        return mapOf(
            "view_uid" to viewUid,
            "type" to type.value,
            "parameters" to parameters,
        )
    }
}
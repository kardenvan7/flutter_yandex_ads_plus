package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event

data class AdEvent(
    private val uid: String,
    private val type: String,
    private val parameters: Map<String, Any?>? = null,
) {
    fun toMap(): Map<*, *> {
        return mapOf(
            "uid" to uid,
            "type" to type,
            "parameters" to parameters,
        )
    }
}
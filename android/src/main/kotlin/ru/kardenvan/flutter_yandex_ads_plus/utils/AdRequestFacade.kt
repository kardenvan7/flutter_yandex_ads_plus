package ru.kardenvan.flutter_yandex_ads_plus.utils

import com.yandex.mobile.ads.common.AdRequest
import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters

class AdRequestFacade {
    companion object {
        fun buildWithParameters(parameters: AdParameters?): AdRequest {
            val requestBuilder = AdRequest.Builder()

            if (parameters != null) {
                requestBuilder.apply {
                    if (parameters.custom != null) {
                        setParameters(parameters.custom)
                    }

                    if (parameters.age != null) {
                        setAge(parameters.age)
                    }

                    if (parameters.biddingData != null) {
                        setBiddingData(parameters.biddingData)
                    }

                    if (parameters.contextQuery != null) {
                        setContextQuery(parameters.contextQuery)
                    }

                    if (parameters.contextTags != null) {
                        setContextTags(parameters.contextTags)
                    }

                    if (parameters.gender != null) {
                        setGender(parameters.gender)
                    }

                    if (parameters.location != null) {
                        setLocation(parameters.location)
                    }

                    if (parameters.preferredTheme != null) {
                        setPreferredTheme(parameters.preferredTheme)
                    }
                }
            }

            return requestBuilder.build()
        }
    }
}
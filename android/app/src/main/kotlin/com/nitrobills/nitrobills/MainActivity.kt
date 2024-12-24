package com.nitrobills.nitrobills



import android.app.usage.NetworkStats
import android.app.usage.NetworkStatsManager
import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

import android.os.Bundle
import android.telephony.SubscriptionInfo
import android.telephony.SubscriptionManager
import android.telephony.TelephonyManager


class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "com.nitrobills.Nitrobills/data_management"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "getDataUsage") {
                val startTime = call.argument<Int>("startTime")!!.toLong()
                val endTime = call.argument<Int>("endTime")!!.toLong()
                val dataUsage = getDataUsage(startTime, endTime)
                result.success(dataUsage)
            } else if (call.method == "getSimInfo") {
                val simInfo = getSimInfo()
                result.success(simInfo)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getDataUsage(startTime: Long, endTime: Long): Map<String, Long> {
        val dataUsage = mutableMapOf<String, Long>()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val networkStatsManager = getSystemService(Context.NETWORK_STATS_SERVICE) as NetworkStatsManager
            val connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

            var mobileDataUsage = 0L
            var wifiDataUsage = 0L

            try {
                val bucket = NetworkStats.Bucket()

                val mobileStats = networkStatsManager.querySummary(NetworkCapabilities.TRANSPORT_CELLULAR, null, startTime, endTime)
                while (mobileStats.hasNextBucket()) {
                    mobileStats.getNextBucket(bucket)
                    mobileDataUsage += bucket.rxBytes + bucket.txBytes
                }

                val wifiStats = networkStatsManager.querySummary(NetworkCapabilities.TRANSPORT_WIFI, null, startTime, endTime)
                while (wifiStats.hasNextBucket()) {
                    wifiStats.getNextBucket(bucket)
                    wifiDataUsage += bucket.rxBytes + bucket.txBytes
                }

                dataUsage["mobile"] = mobileDataUsage
                dataUsage["wifi"] = wifiDataUsage
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
        return dataUsage
    }


    private fun getDataUsageV2(startTime: Long, endTime: Long): Long {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val networkStatsManager = getSystemService(Context.NETWORK_STATS_SERVICE) as NetworkStatsManager
            val connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

            var totalBytes = 0L
            try {
                val networkCapabilities = connectivityManager.getNetworkCapabilities(connectivityManager.activeNetwork)
                val networkType = ConnectivityManager.TYPE_MOBILE
                
                val networkStats = networkStatsManager.querySummary(networkType, null, startTime, endTime)
                val bucket = NetworkStats.Bucket()

                while (networkStats.hasNextBucket()) {
                    networkStats.getNextBucket(bucket)
                    totalBytes += bucket.rxBytes + bucket.txBytes
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
            return totalBytes
        } else {
            return 0L
        }
    }


    private fun getSimInfo(): Map<String, Any?> {
        val simInfo = mutableMapOf<String, Any?>()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
            val subscriptionManager = getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
            val telephonyManager = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

            val subscriptionInfos = subscriptionManager.activeSubscriptionInfoList
            subscriptionInfos?.forEach { info ->
                val number = info.number
                val carrierName = info.carrierName.toString()
                if (info.simSlotIndex == 0) {
                    simInfo["sim1Number"] = number
                    simInfo["sim1Carrier"] = carrierName
                } else if (info.simSlotIndex == 1) {
                    simInfo["sim2Number"] = number
                    simInfo["sim2Carrier"] = carrierName
                }
            }

            // val defaultDataSubId = subscriptionManager.defaultDataSubscriptionId
            // val defaultDataSubId = SubscriptionManager.getDefaultDataSubscriptionId()
            // val activeDataSubId = SubscriptionManager.getActiveDataSubscriptionId()
            // val defaultDataSubInfo = subscriptionManager.getActiveSubscriptionInfo(activeDataSubId)
            // val defaultDataSubInfo = subscriptionManager.getActiveSubscriptionInfo(activeDataSubId)
            // defaultDataSubInfo?.let {
            //    simInfo["currentDataSim"] = if (it.simSlotIndex == 0) "SIM 1" else "SIM 2"
            // }
        }
        return simInfo
    }
}

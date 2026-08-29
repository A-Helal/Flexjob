package com.flexi.jobs.flexi_jobs

import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity() {

    override fun onDestroy() {
        try {
            super.onDestroy()
        } catch (e: Exception) {
            // Fallback: FlutterBarcodeScannerPlugin.clearPluginSetup can throw NPE
            // if lifecycle is null during activity destruction
        }
    }
}

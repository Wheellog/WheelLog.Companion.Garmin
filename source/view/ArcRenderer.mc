using Toybox.WatchUi;
using Toybox.Application.Properties;
using Toybox.Application.Storage;

class ArcRenderer extends WatchUi.Drawable {
    var mCurrent, mMaxValue;

    private var mIdleColor,
        mNormalColor,
        mMediumColor,
        mDangerousColor,
        mStartDegree,
        mEndDegree,
        mXCenterPosition,
        mYCenterPosition,
        mArcRadius,
        mArcSize,
        mDataDrawingDirection,
        mDataSource,
        mDataSourceMaxValue;

    private var screenCenterX = System.getDeviceSettings().screenWidth / 2;
    private var screenCenterY = System.getDeviceSettings().screenHeight / 2;

    private var screenHeight = System.getDeviceSettings().screenHeight;
    private var screenWidth = System.getDeviceSettings().screenWidth;

    var font = WatchUi.loadResource(Rez.Fonts.Tall);

    function initialize(params) {
        Drawable.initialize(params);
        // Here we just get parameters from the layout.xml file
        mIdleColor = params.get(:idleColor);
        mNormalColor = params.get(:normalColor);
        mMediumColor = params.get(:mediumColor);
        mDangerousColor = params.get(:dangerousColor);
        mStartDegree = params.get(:startDegree);
        mEndDegree = params.get(:endDegree);
        if (params.get(:xCenterPosition) == :center) {
            mXCenterPosition = screenCenterX;
        } else {
            mXCenterPosition = params.get(:xCenterPosition);
        }

        if (params.get(:yCenterPosition) == :center) {
            mYCenterPosition = screenCenterY;
        } else {
            mYCenterPosition = params.get(:yCenterPosition);
        }

        if (params.get(:arcRadius) == :max) {
            mArcRadius = screenWidth / 2;
        } else {
            mArcRadius = params.get(:arcRadius);
        }
        mArcSize = params.get(:arcSize);
        mDataDrawingDirection = params.get(:dataDrawingDirection);
        mDataSource = params.get(:dataSource);
        mDataSourceMaxValue = params.get(:dataSourceMaxValue);
    }
    function draw(dc) {
        dc.setPenWidth(mArcSize);
        renderBackgroundArc(dc);
        dc.setColor(0x3F8CFF, 0x000000);
        renderForegroundArc(dc);
        
        getForegroundFill(5);

        dc.drawText(screenCenterX, screenCenterY, font, "22", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function renderForegroundArc(dc) {
        dc.setColor(0x3F8CFF, 0x000000);
        dc.drawArc(
            mXCenterPosition,
            mYCenterPosition,
            mArcRadius,
            Graphics.ARC_CLOCKWISE,
            mStartDegree,
            getForegroundFill(mDataSource)
        );
    }

    function renderBackgroundArc(dc) {
        dc.setColor(0x323232, 0x000000);
        dc.drawArc(mXCenterPosition, mYCenterPosition, mArcRadius, Graphics.ARC_CLOCKWISE, mStartDegree, mEndDegree);
    }

    function getForegroundFill(data) {
        var degreeRange = mStartDegree.abs() + mEndDegree.abs();
        System.println(degreeRange);
        var percentage = data.toFloat() / mDataSourceMaxValue.toFloat();
        System.println(percentage);
        if (mEndDegree < 0) {
            System.println((degreeRange * percentage) - mEndDegree);
            return (degreeRange * percentage) - mEndDegree;
        } else if (mStartDegree < 0) {
            System.println((degreeRange * percentage) - mStartDegree);
            return (degreeRange * percentage) - mStartDegree;
        }
    }


    function setValues(current, max) {
        mCurrent = current;
        mMaxValue = max;
    }
}
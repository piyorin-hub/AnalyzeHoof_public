function transformedPoint = transformPtCloud(ptCloud,translation,rotation)
    tfrom = rigidtform3d(rotation,translation);
    pc = pctransform(ptCloud, tfrom);
    transformedPoint = pc;
end
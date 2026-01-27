function criar_warp(_target_rm, _target_x, _target_y, _target_face)
{
    if (!instance_exists(objWarp))
    {
        var warp = instance_create_depth(0, 0, -676767, objWarp);
        warp.target_rm   = _target_rm;
        warp.target_x    = _target_x;
        warp.target_y    = _target_y;
        warp.target_face = _target_face;
    }
}

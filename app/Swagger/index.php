<?php
/**
 * Created by PhpStorm.
 * User: Kip
 * Date: 5/29/2020
 * Time: 1:06 PM
 */

//base_url/api/documentation
/**
 * @OA\OpenApi(
 *     @OA\Info(
 *         version="1.0",
 *         title="SoftClans API",
 *         description="SoftClans API Portal is a platform for documentation of all our APIs",
 *         @OA\Contact(
 *             email="ronohhilla@gmail.com"
 *         ),
 *         @OA\License(
 *             name="SoftClans License 1.0",
 *             url="http://www.softclans.co.ke"
 *         )
 *     ),
 *     @OA\Server(
 *         description="KIP HOST SERVER",
 *         url=L5_SWAGGER_CONST_HOST
 *     )
 * )
 */

/** @SWG\SecurityScheme(
 *   securityDefinition="passport",
 *   type="oauth2",
 *   tokenUrl="/oauth/token",
 *   flow="password",
 *   scopes={}
 * )
 */
